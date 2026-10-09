# Leantime Helm Chart

Leantime, project management for the non-project manager. For more information, check the project site at <https://leantime.io/>

## Helm Chart

Installation:

```bash
helm install leantime oci://ghcr.io/maarlo/helm-charts/leantime
```

See options below to customize the deployment.

**\* Note**: Auto-generated passwords are overwritten every time the template is rendered but the database only creates credentials on the first run. When upgrading, use "--set" to provide the current passwords otherwise they will not match and application will fail.

## **Main application**

| Option                     | Description                                                 | Format                                                   | Default                                                                 |
| -------------------------- | ----------------------------------------------------------- | -------------------------------------------------------- | ----------------------------------------------------------------------- |
| leantime.name              | Site name                                                   | Text                                                     | Leantime                                                                |
| leantime.language          | Site language                                               | \[2-digit language\]-\[2-digit country\]                 | en-US                                                                   |
| leantime.primaryColor      | Main color                                                  | #6-digit RGB hex                                         | #006d9f                                                                 |
| leantime.secondaryColor    | Secondary color                                             | #6-digit RGB hex                                         | #00a886                                                                 |
| leantime.defaultTheme      | Default site theme                                          | Text                                                     | Empty. Uses the application default (default)                           |
| leantime.keepTheme         | Keep theme and language from previous user for login screen | true / false                                             | true                                                                    |
| leantime.logo              | Site logo image path                                        | File path                                                | Logo at /images/logo.svg                                                |
| leantime.printLogo         | Site logo image path for printing, must be jpg or png       | File path                                                | /images/logo.jpg                                                        |
| leantime.defaultTimezone   | Default Timezone                                            | Text [list](https://www.php.net/manual/en/timezones.php) | Empty. Uses the application default (America/Los_Angeles)               |
| leantime.url               | Base URL                                                    | Full URL (protocol://host.domain.tld)                    | Empty. If using Ingress or IngressRoute, URL is generated automatically |
| leantime.sessionExpiration | Session expiration                                          | Number of seconds                                        | 28800 (8hrs)                                                            |
| leantime.sessionSalt       | Session salt                                                | Text                                                     | Randomly generated                                                      |
| leantime.disableLoginForm  | If true then don't show the login form                      | true / false                                             | false                                                                   |
| leantime.projectMenu       | Allow per-project menu                                      | true / false                                             | false                                                                   |
| leantime.debug             | Enable debug                                                | 0 (Disabled) or 1 (Enabled)                              | 0 (Disabled)                                                            |
| leantime.existingSecret    | Use existing secret for session salt. Key is 'session-salt' | Secret name                                              | Not defined                                                             |

## **Application Features**

| Option                                    | Description                                                                                           | Format                                 | Default                                             |
| ----------------------------------------- | ----------------------------------------------------------------------------------------------------- | -------------------------------------- | --------------------------------------------------- |
| leantime.mysql.host                       | MySQL host                                                                                            | Text                                   | {{ .Release.Name }}-mariadb                         |
| leantime.mysql.port                       | MySQL port                                                                                            | Number                                 | 3306                                                |
| leantime.mysql.database                   | MySQL database name                                                                                   | Text                                   | leantime                                            |
| leantime.mysql.user                       | MySQL user                                                                                            | Text                                   | Empty                                               |
| leantime.mysql.password                   | MySQL password                                                                                        | Text                                   | Empty                                               |
| leantime.mysql.existingSecret             | Use existing secret for database credentials. Keys are 'database-user' and 'database-password'        | Secret name                            | Not defined                                         |
|                                           |                                                                                                       |                                        |                                                     |
| leantime.redis.enabled                    | Enable Redis support                                                                                  | true / false                           | false                                               |
| leantime.redis.url                        | Redis URL, if empty the fields below will be used                                                     | tcp://hostname:port                    | Empty                                               |
| leantime.redis.host                       | Redis Host **(required if URL is not used)**                                                          | Hostname                               | {{ .Release.Name }}-valkey                          |
| leantime.redis.port                       | Redis Port                                                                                            | Number                                 | 6379                                                |
| leantime.redis.password                   | Redis Password if used, existingSecret has preference                                                 | Text                                   | Empty                                               |
| leantime.redis.scheme                     | Redis connection scheme                                                                               | tcp, tls                               | tcp                                                 |
| leantime.redis.existingSecret             | Use existing secret for Redis password, key 'redis-password'                                          | Secret name                            | Not defined                                         |
|                                           |                                                                                                       |                                        |                                                     |
| leantime.s3.enabled                       | Enable S3 File storage                                                                                | true / false                           | false                                               |
| leantime.s3.endpoint                      | Custom https endpoint                                                                                 | Empty or https url                     | Empty                                               |
| leantime.s3.usePathStyleEndpoint          | Switch between path or subdomain style endpoint url                                                   | true / false                           | false                                               |
| leantime.s3.key                           | S3 Key **(required)**                                                                                 | Text                                   | Empty                                               |
| leantime.s3.secret                        | S3 Secret **(required)**                                                                              | Text                                   | Empty                                               |
| leantime.s3.bucket                        | S3 Bucket **(required)**                                                                              | Text                                   | Empty                                               |
| leantime.s3.region                        | S3 Region **(required)**                                                                              | Text                                   | Empty                                               |
| leantime.s3.folder                        | Use sub-folder                                                                                        | Path                                   | Empty                                               |
| leantime.s3.existingSecret                | Use existing secret for S3 key and secret. Keys are 's3-key' and 's3-secret'                          | Secret name                            | Not defined                                         |
|                                           |                                                                                                       |                                        |                                                     |
| leantime.smtp.enabled                     | Enable SMTP support                                                                                   | true / false                           | false                                               |
| leantime.smtp.from                        | E-mail sender address **(required)**                                                                  | e-mail                                 | Empty                                               |
| leantime.smtp.host                        | SMTP server **(required)**                                                                            | hostname                               | Empty                                               |
| leantime.smtp.auth                        | SMTP requires authentication?                                                                         | true / false                           | true                                                |
| leantime.smtp.username                    | SMTP username **(required)** unless existing secret is used or auth is disabled                       | Text                                   | Empty                                               |
| leantime.smtp.password                    | SMTP password **(required)** unless existing secret is used or auth is disabled                       | Text                                   | Empty                                               |
| leantime.smtp.existingSecret              | Use existing secret for SMTP username and password. Keys are 'smtp-username' and 'smtp-password'      | Secret name                            | Not defined                                         |
| leantime.smtp.port                        | Use non-standard SMTP port                                                                            | Number                                 | Default SMTP ports                                  |
| leantime.smtp.secureProtocol              | Force specific security protocol                                                                      | tls, ssl or starttls                   | Auto-detect                                         |
| leantime.smtp.autoTLS                     | Enable TLS automatically if supported by server                                                       | true / false                           | true                                                |
| leantime.smtp.insecureSSL                 | Allow insecure SSL: Don't verify certificate, accept self-signed, etc.                                | true / false                           | false                                               |
|                                           |                                                                                                       |                                        |                                                     |
| leantime.ldap.enabled                     | Enable LDAP support                                                                                   | true / false                           | false                                               |
| leantime.ldap.uri                         | LDAP URI                                                                                              | ldap\[s\]://hostname:port              | Empty                                               |
| leantime.ldap.host                        | LDAP server, required if URI is not set                                                               | hostname                               | Empty                                               |
| leantime.ldap.port                        | LDAP listener port                                                                                    | Number                                 | 389                                                 |
| leantime.ldap.userDN                      | DN to search users **(required)**                                                                     | DN (e.g. CN=users,DC=example,DC=com)   | Empty                                               |
| leantime.ldap.domain                      | LDAP domain to append on usernames                                                                    | Domain name (e.g. example.com)         | Empty                                               |
| leantime.ldap.type                        | LDAP server type                                                                                      | OL (OpenLDAP) or AD (Active Directory) | OL                                                  |
| leantime.ldap.keys                        | Mapping of user fields with LDAP user attributes                                                      | JSON                                   | OL attributes (uid, memberof, mail and displayname) |
| leantime.ldap.groupRoles                  | Mapping of user role with LDAP group                                                                  | JSON                                   | Owner access to "Administrators"                    |
| leantime.ldap.defaultRole                 | Default role if no mapped group is found                                                              | Number                                 | 20 (Editor)                                         |
|                                           |                                                                                                       |                                        |                                                     |
| leantime.oidc.enabled                     | Enable OIDC support                                                                                   | true / false                           | false                                               |
| leantime.oidc.clientId                    | Client ID **(required)** unless existing secret is used                                               | Text                                   | Empty                                               |
| leantime.oidc.clientSecret                | Client Secret **(required)** unless existing secret is used                                           | Text                                   | Empty                                               |
| leantime.oidc.providerUrl                 | Provider URL **(required)**                                                                           | Text                                   | Empty                                               |
| leantime.oidc.createUser                  | Create Leantime user if it doesn't exist, otherwise fail login                                        | true / false                           | false                                               |
| leantime.oidc.defaultRole                 | Default role for users created via OIDC                                                               | Number                                 | 20 (Editor)                                         |
| leantime.oidc.existingSecret              | Use existing secret for OIDC client id and secret. Keys are 'oidc-client-id' and 'oidc-client-secret' | Secret name                            | Not defined                                         |
| leantime.oidc.overrides.authUrl           | Auth URL                                                                                              | URL                                    | Empty                                               |
| leantime.oidc.overrides.tokenUrl          | Token URL                                                                                             | URL                                    | Empty                                               |
| leantime.oidc.overrides.jwksUrl           | JSON Web Key Sets URL                                                                                 | URL                                    | Empty                                               |
| leantime.oidc.overrides.userInfoUrl       | User Info URL                                                                                         | URL                                    | Empty                                               |
| leantime.oidc.overrides.certificateString | Certificate String                                                                                    | Text                                   | Empty                                               |
| leantime.oidc.overrides.certificateFile   | Certificate File                                                                                      | Text                                   | Empty                                               |
| leantime.oidc.overrides.scopes            | OIDC Scopes                                                                                           | Text                                   | Empty                                               |
| leantime.oidc.overrides.fields.email      | Email                                                                                                 | Text                                   | Empty                                               |
| leantime.oidc.overrides.fields.firstName  | First Name                                                                                            | Text                                   | Empty                                               |
| leantime.oidc.overrides.fields.lastName   | Last Name                                                                                             | Text                                   | Empty                                               |
| leantime.oidc.overrides.fields.phone      | Phone                                                                                                 | Text                                   | Empty                                               |
| leantime.oidc.overrides.fields.jobTitle   | Job Title                                                                                             | Text                                   | Empty                                               |
| leantime.oidc.overrides.fields.jobLevel   | Job Level                                                                                             | Text                                   | Empty                                               |
| leantime.oidc.overrides.fields.department | Department                                                                                            | Text                                   | Empty                                               |
|                                           |                                                                                                       |                                        |                                                     |
| leantime.ratelimit.general                | General rate limit                                                                                    | Number                                 | 100                                                 |
| leantime.ratelimit.api                    | API rate limit                                                                                        | Number                                 | 10                                                  |
| leantime.ratelimit.auth                   | Auth rate limit                                                                                       | Number                                 | 20                                                  |
|                                           |                                                                                                       |                                        |                                                     |
| leantime.extraEnv                         | Custom environment variables, to be more flexible with custom images (e.g. `LEAN_XXX: value`)         | Map                                    | Empty                                               |

## **Network**

| Option                        | Description                                                                                                                                                             | Format                              | Default       |
| ----------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------- | ------------- |
| service.type                  | Service Type. [More Information](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types)                                    | ClusterIP / NodePort / LoadBalancer | ClusterIP     |
| service.port                  | Service port for HTTP server                                                                                                                                            | Number                              | 80            |
| service.externalTrafficPolicy | External Traffic Policy. [More Information](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) | Local / Cluster                     | Cluster       |
| service.loadBalancerIP        | Manually select IP when type is LoadBalancer                                                                                                                            | IP address                          | Not defined   |
| service.nodePorts.http        | Manually select node port for http                                                                                                                                      | Number                              | Empty         |
|                               |                                                                                                                                                                         |                                     |               |
| ingress.enabled               | Enable Ingress                                                                                                                                                          | true / false                        | false         |
| ingress.className             | Name of the ingress class                                                                                                                                               | Text                                | Empty         |
| ingress.host                  | Ingress hostname **(required)**                                                                                                                                         | Hostname                            | Empty         |
| ingress.path                  | Ingress path                                                                                                                                                            | Text                                | Empty         |
| ingress.annotations           | Ingress annotations                                                                                                                                                     | Map                                 | Empty         |
| ingress.tls                   | Ingress TLS options                                                                                                                                                     | Array of Maps                       | Empty         |
|                               |                                                                                                                                                                         |                                     |               |
| ingressRoute.enabled          | Enable Traefik IngressRoute CRD                                                                                                                                         | true / false                        | false         |
| ingressRoute.className        | Name of the ingress class                                                                                                                                               | Text                                | Empty         |
| ingressRoute.host             | Ingress route hostname **(required)**                                                                                                                                   | Hostname                            | Empty         |
| ingressRoute.entrypoints      | List of Traefik endpoints                                                                                                                                               | Array of Text                       | \[websecure\] |
| ingressRoute.tls              | Ingress route TLS options (e.g. `certResolver: letsencrypt`)                                                                                                            | Map (or empty Array)                | Empty (\[\])  |

## **Storage**

**Note**: If persistence is not enabled, data will be held on "Empty Dir" which is created on the first time the Pod runs on a node. If Pod is deleted or moved to another node, data will be lost.

| Option                         | Description                                                                                                                                           | Format       | Default                                |
| ------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------- | ------------ | -------------------------------------- |
| additionalVolumes              | Additional volumes definitions, to be used by sidecars [Spec](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#volumes) | Array        | Not defined                            |
|                                |                                                                                                                                                       |              |                                        |
| userFilesStorage.enabled       | Use persistent volume (PVC) for user files. Uses sub-paths 'userfiles' and 'public-userfiles'                                                         | true / false | false                                  |
| userFilesStorage.size          | Size of volume                                                                                                                                        | Size         | 1Gi                                    |
| userFilesStorage.accessMode    | Volume access mode                                                                                                                                    | Text         | ReadWriteOnce                          |
| userFilesStorage.storageClass  | Storage Class                                                                                                                                         | Text         | Not defined. Use "-" for default class |
| userFilesStorage.existingClaim | Use existing PVC                                                                                                                                      | Name of PVC  | Not defined                            |
| userFilesStorage.annotations   | PVC annotations                                                                                                                                       | Map          | Empty                                  |
|                                |                                                                                                                                                       |              |                                        |
| pluginsStorage.enabled         | Use persistent volume (PVC) for plugins. Mounts to /var/www/html/app/Plugins                                                                          | true / false | false                                  |
| pluginsStorage.size            | Size of volume                                                                                                                                        | Size         | 1Gi                                    |
| pluginsStorage.accessMode      | Volume access mode                                                                                                                                    | Text         | ReadWriteOnce                          |
| pluginsStorage.storageClass    | Storage Class                                                                                                                                         | Text         | Not defined. Use "-" for default class |
| pluginsStorage.existingClaim   | Use existing PVC                                                                                                                                      | Name of PVC  | Not defined                            |

## **Image**

| Option           | Description                                                                                                         | Format                        | Default                           |
| ---------------- | ------------------------------------------------------------------------------------------------------------------- | ----------------------------- | --------------------------------- |
| image.repository | Leantime Docker image                                                                                               | Text                          | leantime/leantime                 |
| image.tag        | Docker image tag                                                                                                    | Text                          | Empty. Uses appVersion from Chart |
| image.pullPolicy | Image pull policy. [More Information](https://kubernetes.io/docs/concepts/configuration/overview/#container-images) | Always / IfNotPresent / Never | IfNotPresent                      |
| imagePullSecrets | Image pull secrets                                                                                                  | Array                         | Empty                             |

## **Database (MariaDB)**

**Note**: The embedded database is provided by the MariaDB subchart. When it is disabled, configure an external database with the `leantime.mysql.*` options.

| Option                                  | Description                                                    | Format       | Default                |
| --------------------------------------- | -------------------------------------------------------------- | ------------ | ---------------------- |
| mariadb.enabled                         | Enable embedded MariaDB database                               | true / false | true                   |
| mariadb.auth.database                   | MariaDB database name                                          | Text         | leantime               |
| mariadb.auth.username                   | MariaDB database user (leave empty for root user)              | Text         | leantime               |
| mariadb.auth.password                   | MariaDB database password                                      | Text         | Empty                  |
| mariadb.auth.rootPassword               | MariaDB root password                                          | Text         | Empty                  |
| mariadb.auth.existingSecret             | Existing secret containing the MariaDB root and user passwords | Secret name  | Empty                  |
| mariadb.auth.secretKeys.rootPasswordKey | Secret key for the MariaDB root password                       | Text         | database-root-password |
| mariadb.auth.secretKeys.userPasswordKey | Secret key for the MariaDB user password                       | Text         | database-password      |

## **Cache (Valkey)**

**Note**: The embedded Valkey is provided by a subchart and is used as the Redis-compatible server. To make Leantime use it, also set `leantime.redis.enabled` to `true` (it is `false` by default). To use an external server instead, set `valkey.enabled` to `false` and configure `leantime.redis.*`.

| Option                                | Description                                           | Format       | Default        |
| ------------------------------------- | ----------------------------------------------------- | ------------ | -------------- |
| valkey.enabled                        | Enable embedded Valkey in-memory data structure store | true / false | true           |
| valkey.auth.enabled                   | Enable password authentication                        | true / false | true           |
| valkey.auth.password                  | Valkey password                                       | Text         | Empty          |
| valkey.auth.existingSecret            | Name of an existing secret with Valkey credentials    | Secret name  | Empty          |
| valkey.auth.existingSecretPasswordKey | Password key to be retrieved from the existing secret | Text         | redis-password |

## **General Kubernetes/Helm**

| Option                                      | Description                                                                                                                                           | Format       | Default                 |
| ------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- | ------------ | ----------------------- |
| replicaCount                                | Number of pod replicas                                                                                                                                | Number       | 1                       |
| revisionHistoryLimit                        | Number of old ReplicaSets to retain                                                                                                                   | Number       | 10                      |
| nameOverride                                | Name override                                                                                                                                         | Text         | Empty                   |
| fullnameOverride                            | Full name override                                                                                                                                    | Text         | Empty                   |
| serviceAccount.create                       | Create Service Account                                                                                                                                | true / false | false                   |
| serviceAccount.annotations                  | Annotations service account                                                                                                                           | Map          | Empty                   |
| serviceAccount.name                         | Service Account name                                                                                                                                  | Text         | Generated from template |
| serviceAccount.automountServiceAccountToken | Allows auto mount of ServiceAccountToken on the serviceAccount created                                                                                | true / false | false                   |
| automountServiceAccountToken                | Mount Service Account token in pod                                                                                                                    | true / false | false                   |
| deploymentAnnotations                       | Deployment Annotations                                                                                                                                | Map          | Empty                   |
| probes.liveness                             | Liveness options [Spec](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes)       | Map          | Empty                   |
| probes.readiness                            | Readiness options [Spec](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes)      | Map          | Empty                   |
| initContainers                              | Init container definitions, no templating possible [Spec](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#Container)   | Array        | Empty                   |
| sidecars                                    | Sidecar container definition, no templating possible [Spec](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#Container) | Array        | Empty                   |
| podAnnotations                              | Pod Annotations                                                                                                                                       | Map          | Empty                   |
| podLabels                                   | Extra Pod Labels                                                                                                                                      | Map          | Empty                   |
| podSecurityContext                          | Pod-level Security Context                                                                                                                            | Map          | Empty                   |
| securityContext                             | Container-level Security Context                                                                                                                      | Map          | Empty                   |
| resources                                   | Deployment Resources                                                                                                                                  | Map          | Empty                   |
| nodeSelector                                | Node selector                                                                                                                                         | Map          | Empty                   |
| tolerations                                 | Tolerations                                                                                                                                           | Array        | Empty                   |
| affinity                                    | Affinity                                                                                                                                              | Map          | Empty                   |

## Acknowledgment

This repository is based on [Gissilabs Charts](https://github.com/gissilabs/charts).
