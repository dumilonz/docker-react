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
# copy something from other phase (builder)
# copied to location as indicated in docker hub for nginx image
COPY --from=builder /usr/app/build /usr/share/nginx/html
