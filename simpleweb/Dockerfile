# Specify a base image
FROM node:alpine

WORKDIR /usr/app

# Install some dependencies
COPY package.json /usr/app
RUN npm install


# Defualt command
CMD ["npm", "start"]
    

