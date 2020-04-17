# tag it as the builder phase. 
# Everything below it is part of the builder
FROM node:alpine as builder
WORKDIR '/usr/app'
COPY ./package.json .
RUN npm install
COPY . .
RUN npm run build 

# /usr/app/build is the folder that has all the information in it from builder

FROM nginx
# when doing this on local machine you should just include this a flag in the docker run. It will not work
# But since this is now wrapped in a CI program you need to expose it from insdie the dockerfile. 
# Elasticbeanstalk is clever and will expose it for us
EXPOSE 80
# copy something from other phase (builder)
# copied to location as indicated in docker hub for nginx image
COPY --from=builder /usr/app/build /usr/share/nginx/html
