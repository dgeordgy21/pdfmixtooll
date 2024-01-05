https://github.com/kasmtech/workspaces-core-images


    docker run -d --shm-size=512m -p 6901:6901 -e VNC_PW=password dgeordgy21/pdfmixtool:latest

The container is now accessible via a browser : https://IP:6901

    User : kasm_user
    Password: password






    sudo docker build -t dgeordgy21/pdfmixtool -f Dockerfile .
