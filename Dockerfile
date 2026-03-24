FROM node:20-slim

WORKDIR /app

# 🔥 Instala OpenSSL (OBRIGATÓRIO pro Prisma)
RUN apt-get update -y && apt-get install -y openssl

# 🔥 Copia dependências primeiro (cache melhor)
COPY package*.json ./

RUN npm install

# 🔥 Copia o resto do projeto
COPY . .

# 🔥 Garante que Prisma gera o client corretamente
RUN npx prisma generate

# 🔥 Build do TypeScript
RUN npm run build

# 🔥 Porta do Fly
EXPOSE 3000

# 🔥 Comando final
CMD ["npm", "start"]