import { jwtDecode } from 'jwt-decode';

const UsernameSchema = 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name';
const EmailSchema = 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress';
const IdSchema = 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier';

export class UserInfo {
    username: string;
    email: string;
    id: string;
}

export function getUserInfo(): UserInfo | undefined {
    const cerberAuthCookieExists = getCookie('CerberAuth');
    if (!cerberAuthCookieExists) {
        return;
    }
    const cerberAuthValue = getCookieValue('CerberAuth');
    const payload = jwtDecode(cerberAuthValue);
    const userInfo = new UserInfo();
    userInfo.username = payload[UsernameSchema];
    userInfo.email = payload[EmailSchema];
    userInfo.id = payload[IdSchema];
    return userInfo;
}

function getCookie(name: string) {
    return document.cookie.split(';').some((c) => {
        return c.trim().startsWith(name + '=');
    });
}

function getCookieValue(name: string) {
    const cookie = document.cookie.split(';').find((c) => c.trim().startsWith(name + '='));

    if (cookie) {
        return cookie.split('=')[1];
    }

    return '';
}
