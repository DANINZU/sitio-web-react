# Etapa 1: Construcción (Build)
FROM node:lts-alpine AS build
RUN apk update && apk upgrade --no-cache
WORKDIR /app
# Copiar dependencias e instalar
COPY package*.json ./
RUN npm install
# Copiar el resto del código y compilar para producción
COPY . .
RUN npm run build

# Etapa 2: Producción
# Utilizar Alpine y Nginx asegura una base ligera sin archivos innecesarios
FROM nginx:alpine
RUN apk update && apk upgrade --no-cache
RUN apk upgrade --no-cache
# Copiar únicamente los archivos estáticos de la carpeta 'dist' generada en la Etapa 1
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
