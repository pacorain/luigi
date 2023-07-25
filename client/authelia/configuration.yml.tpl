---
theme: auto
jwt_secret: {{ op://prod/authelia/jwt_secret }}

# default_redirection_url: None

default_2fa_method: "webauthn"

server:
  host: 0.0.0.0
  port: 9091
  path: ""
  enable_pprof: false
  enable_expvars: false

log:
  level: debug

totp:
  issuer: {{ op://prod/authelia/url }}
  algorith: sha1
  digits: 6
  period: 30
  skew: 1
  secret_size: 32

webauthn:
  timeout: 60s
  display: Rainwater Home
  attestation_conveyance_preference: inderect
  user_verification: preferred

ntp:
  address: "time.cloudflare.com:123"
  version: 4
  max_desync: 3s
  disable_startup_check: false
  disable_failure: false

authentication_backend:
  password_reset:
    disable: false
    custom_url: ""

  file:
    path: /config/users_database.yml
    watch: true
    password:
      algorithm: argon2
      argon2:
        variant: argon2id
        iterations: 3
        memory: 65536
        parallelism: 4
        salt_length: 16
        key_length: 32

password_policy:
  standard:
    enabled: false
    min_length: 8
    max_length: 0
    require_uppercase: true
    require_lowercase: true
    require_special: true
  
  zxcvbn:
    enabled: true
    min_score: 3
    
access_control:
  default_policy: two_factor

session:
  name: authelia_session
  domain: {{ op://prod/authelia/domain }}
  same_site: lax
  secret: {{ op://prod/authelia/session_secret }}
  expiration: 1h
  inactivity: 5m
  remember_me_duration: 336h

regulation:
  max_retries: 3
  find_time: 1m
  ban_time: 5m

storage:
  encryption_key: {{ op://prod/authelia/storage_encryption_key }}
  local:
    path: /config/db.sqlite3

notifier:
  disable_startup_check: false
  filesystem:
    filename: /config/notification.txt
...