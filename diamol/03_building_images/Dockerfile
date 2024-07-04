FROM diamol/node

CMD ["node", "/web-ping/app.js"]

# Otimize: Use only one ENV instruction to set ultiple environment variables.
ENV TARGET="mariusbutuc.com" \
  METHOD="HEAD" \
  INTERVAL="3000"

WORKDIR /web-ping
COPY app.js .

# Otimize: Unlikely to change, hence move to the top, after FROM.
# CMD ["node", "/web-ping/app.js"]
