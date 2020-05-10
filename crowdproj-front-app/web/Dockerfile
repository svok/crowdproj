FROM nginx
COPY assets \
    /usr/share/nginx/html/assets
COPY index.html \
    flutter_service_worker.js \
    main.dart.js \
    main.dart.js.map \
    /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx","-g","daemon off;"]
