FROM registry.suse.com/bci/nodejs:22  AS BUILDER

WORKDIR /app

RUN npm install -g pnpm@latest-10
# RUN wget -qO- https://get.pnpm.io/install.sh | ENV="$HOME/.bashrc" SHELL="$(which bash)" bash -

COPY . /app

RUN pnpm install

RUN pnpm run nuxt generate

FROM registry.suse.com/suse/nginx:1.21 AS PRODUCTION

COPY --from=BUILDER /app/packages/frontendmu-nuxt/dist /srv/www/htdocs/
