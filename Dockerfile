FROM aquasec/trivy:0.59.0

RUN addgroup -S scannergroup && adduser -S scanneruser -G scannergroup

# NOTE: update to latest secure libcrypto3 version
RUN apk add --no-cache libcrypto3=3.3.2-r1

USER scanneruser

HEALTHCHECK --timeout=1s --retries=1 CMD trivy --version || exit 1

# NOTE: `--db-repository` is needed because sometimes GHCR hits the rate limit, and AWS will be used instead.
ENTRYPOINT ["trivy", "image", \
            "--db-repository", "ghcr.io/aquasecurity/trivy-db,public.ecr.aws/aquasecurity/trivy-db", \
            "--format", "table", \
            "--exit-code", "1", \
            "--ignore-unfixed", \
            "--pkg-types", "os,library", \
            "--severity", "CRITICAL,HIGH,MEDIUM,LOW", \
            "--image-config-scanners", "misconfig,secret", \
            "--scanners", "vuln,secret,misconfig"]