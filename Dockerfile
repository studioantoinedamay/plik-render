FROM ubuntu:22.04

RUN apt-get update && apt-get install -y curl tar ca-certificates

COPY plikd /usr/local/bin/plikd
RUN chmod +x /usr/local/bin/plikd

COPY plikd.cfg /plikd.cfg

EXPOSE 8080

CMD ["/usr/local/bin/plikd", "--config", "/plikd.cfg"]

