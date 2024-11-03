from node:22-slim
env PNPM_HOME="/pnpm"
env PATH="$PNPM_HOME:$PATH"
workdir /app
env LANG=en_US.UTF-8
run corepack enable

# sys deps
run apt-get update \
  && apt-get install curl gnupg -y \
  && curl --location --silent https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    fonts-dejavu-core \
    fonts-ipafont-gothic \
    fonts-wqy-zenhei \
    fonts-thai-tlwg \
    fonts-khmeros \
    fonts-kacst \
    fonts-freefont-ttf \
    dbus \
    imagemagick \
  && apt-get install google-chrome-stable tree -y --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

# copy in workspace installation minimum
# gid 100 (users) is my NAS user's gid. gid 100 already on the node image as users group.
run usermod -g users -aG node node
run chown -R node:users /app
user node
