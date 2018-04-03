module.exports = {
  'apps': [
    {
      'name': 'ims.core.administration',
      'script': process.env.NODE_ENV === 'development' ? './dist/server/index.dev.js' : './dist/server/index.js',
      'cwd': '/usr/local/ims/packages/ims.core.administration',
      'watch': false,
      'env': {
        'DATABASE_ADMIN_PASSWORD': process.env.DATABASE_ADMIN_PASSWORD,
        'DATABASE_ADMIN_USER': process.env.DATABASE_ADMIN_USER,
        'DATABASE_INSTANCE_NAME': process.env.DATABASE_INSTANCE_NAME,
        'DATABASE_NAME': 'ims.core.administration',
        'DATABASE_SERVER': process.env.DATABASE_SERVER,
        'FILE_STORAGE_PATH': '/usr/local/ims/store/ims.core.administration',
        'HUB_DATABASE_NAME': 'ims.core.administration',
        'HUB_URL': process.env.HUB_URL,
        'LOGIN_PASSWORD': '',
        'LOGIN_USERNAME': 'ims.core.administration',
        'MAIL_AUTH_PASS': '',
        'MAIL_AUTH_TYPE': 'login',
        'MAIL_AUTH_USER': '',
        'MAIL_FROM_ADDR': 'noreply@mail.ims.gateway',
        'MAIL_FROM_NAME': 'IMS',
        'MAIL_HOST': 'mail.ims.gateway',
        'MAIL_IGNORE_TLS': 'true',
        'MAIL_PORT': '25',
        'MAIL_SECURE': 'false',
        'MONGO_CONNECTION_STRING': process.env.MONGO_CONNECTION_STRING,
        'PACKAGE_ACCESS_PASSWORD': 'Password1',
        'PORT': 3000,
        'UDP_MULTICAST_ADDRESS': '239.255.255.255',
        'UDP_PORT': '33333',
        'PACKAGE_SECRET': '',
        'FOLDER_SCANNING_ENABLED': process.env.FOLDER_SCANNING_ENABLED
      }
    }
  ]
}
