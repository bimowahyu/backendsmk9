import http from 'k6/http';
import { check, group } from 'k6';
import { sleep } from 'k6';

const file = open('./keluar.png', 'b');

export let options = {
    stages: [
        { duration: '30s', target: 10 },
        { duration: '1m', target: 20 },
        { duration: '30s', target: 0 }
    ],
    thresholds: {
        'http_req_duration': ['p(95)<2000'], // 95% of requests should be under 2s
        'http_req_failed': ['rate<0.5'], // Less than 50% of requests can fail
    }
};

export default function () {
    const baseUrl = 'http://[2407:6ac0:4:5:1234:4321:996d:1]:2000';
    const loginUrl = `${baseUrl}/login`;
    const absensiUrl = `${baseUrl}/createabsensi`;

    const loginPayload = JSON.stringify({
        username: 'testsiswa',
        password: 'testsiswa',
    });

    const loginHeaders = { 
        'Content-Type': 'application/json' 
    };

    group('Login Test', () => {
        let loginRes = http.post(loginUrl, loginPayload, { headers: loginHeaders });

        console.log('Login response status:', loginRes.status);
        console.log('Login response body:', loginRes.body);

        let loginCheck = check(loginRes, {
            'login status is 200': (r) => r.status === 200,
            'login returns user details': (r) => {
                try {
                    const body = JSON.parse(r.body);
                    console.log('Login response parsed body:', body);
                    return body.id && body.name && body.role === 'siswa';
                } catch (err) {
                    console.error('Failed to parse login response body:', err);
                    return false;
                }
            }
        });

        if (!loginCheck) {
            console.error('Login failed. Exiting test...');
            return;
        }

        let cookies = loginRes.cookies['connect.sid'] ? loginRes.cookies['connect.sid'][0].value : null;
        if (!cookies) {
            console.error('Cookie connect.sid not found after login.');
            return;
        }
        console.log('Received session cookie:', cookies);

        const formData = {
            image: http.file(file, 'keluar.png', 'image/png'),
        };

        const absensiHeaders = {
            'Cookie': `connect.sid=${cookies}`,
        };

        group('Absensi Creation Test', () => {
            const absensiRes = http.post(absensiUrl, formData, { 
                headers: absensiHeaders 
            });

            console.log('Absensi response status:', absensiRes.status);
            console.log('Absensi response body:', absensiRes.body);

            check(absensiRes, {
                'absensi status is 200': (r) => r.status === 200,
                'absensi success message': (r) => r.body.includes('Absensi masuk berhasil tersimpan'),
            });
        });
    });

    sleep(1);
}
