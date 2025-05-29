FROM aquasec/trivy:0.63.0

RUN addgroup -S scannergroup && adduser -S scanneruser -G scannergroup

# NOTE: ignoring "Only One Entrypoint" because it seems to be false-positive for Dockerfiles like this one.
RUN echo "AVD-DS-0007" > /home/scanneruser/.trivyignore

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
            "--scanners", "vuln,secret,misconfig", \
            "--ignorefile", "/home/scanneruser/.trivyignore"]
