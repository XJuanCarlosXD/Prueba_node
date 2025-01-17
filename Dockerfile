# Usa una imagen base de Node.js
FROM node:18

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia el package.json y package-lock.json (o yarn.lock) y luego instala las dependencias
COPY package*.json ./
RUN npm install

# Copia el resto de la aplicación al contenedor
COPY . .

# Instala herramientas de Linux necesarias
RUN apt-get update && \
    apt-get install -y \
    calibre \
    qpdf \
    pandoc \
    imagemagick \
    ffmpeg \
    libavcodec-extra \
    libreoffice \
    poppler-utils \
    docx2txt \
    a2ps \
    ghostscript \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# # Actualiza pip y luego instala pdf2ebook y pdf2docx
# RUN pip3 install --upgrade pip && \
#     pip3 install pdf2ebook pdf2docx

# Compila la aplicación
RUN npm run build

# Expose el puerto 8000
EXPOSE 8000

# Comando por defecto para ejecutar la aplicación
CMD ["npm", "start"]