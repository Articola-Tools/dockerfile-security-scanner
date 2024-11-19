FROM aquasec/trivy:0.57.1

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