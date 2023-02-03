FROM python:3.9.13-slim


COPY .git/ /Mio-Controllo/.git/
COPY /MioControllo /Mio-Controllo/MioControllo
COPY Mio.cron /etc/cron.d/Mio.cron
COPY entry.sh script.sh update.sh /Mio-Controllo/
RUN set -ex \
    && apt-get update --no-install-recommends -y \
    && apt-get install --no-install-recommends -y  \
    chromium \ 
    git \ 
    vim \
    nano \
    tzdata \
    cron \
    && rm -rf /var/lib/apt/lists/* \
    && touch /var/log/cron.log \
    && adduser --system nonroot \
    && chown -R nonroot /Mio-Controllo \
    && chmod 0777 /etc/cron.d/Mio.cron \
    && chmod +x /Mio-Controllo/entry.sh \
    && chmod +x /Mio-Controllo/update.sh \
    && chmod u+s /usr/sbin/cron 	
# Set display port as an environment variable
ENV DISPLAY=:99
ENV PATH="/home/nonroot/.local/bin:${PATH}"
ENV UPDATE="0 0 */1 * *"
ENV SCH="0 */8 * * *"
ENV TZ="America/New_York"
SHELL ["/bin/bash", "-ec"]
USER nonroot
WORKDIR /Mio-Controllo/MioControllo
ENTRYPOINT ["/bin/bash", "/Mio-Controllo/entry.sh"]

