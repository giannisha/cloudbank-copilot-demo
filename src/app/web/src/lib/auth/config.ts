import { CLIENT_ID, CLOUD_INSTANCE, TENANT_ID, CLIENT_SECRET, REDIRECT_URI, LOGOUT_URI } from '$env/static/private';

export const msalConfig = {
  auth: {
    clientId: CLIENT_ID,
    authority: CLOUD_INSTANCE + TENANT_ID,
    redirectUri: REDIRECT_URI,
    postLogoutRedirectUri: LOGOUT_URI,
    capabilities: ['api://' + CLIENT_ID + '/.default'],
    clientSecret: CLIENT_SECRET
  }
};