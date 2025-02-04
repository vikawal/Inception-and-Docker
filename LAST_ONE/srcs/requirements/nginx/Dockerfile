FROM alpine:3.16
RUN	apk update && apk upgrade && apk add --no-cache nginx
# install packages, but no store indexes of the packages
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
# run nginx, global, not in backgrouns - as main process