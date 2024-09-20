# Devtoberfest 2024 🍺- Extending your On-Premise OData Entities in CAP
Extend the [Postgres Beershop](https://github.com/gregorwolf/pg-beershop) 🍺 service using an external CAP service. Shoutout to [Gregor Wolf](https://github.com/gregorwolf).  

![Node.js 18.18.0](https://img.shields.io/badge/Node.js-v18.18.0-green)
![@sap/cds 8.2.2](https://img.shields.io/badge/@sap/cds-v8.2.2-green)


## Getting started

Open a new terminal and run the following commands (one at a time)
```
# Download the Beershop repo and start running it on port 4005
git clone https://github.com/gregorwolf/pg-beershop.git 
cd pg-beershop 
npm install
cds watch --port 4005

# Download our repo and start running it on port 4004
git clone https://github.com/shebang-software/devtoberfest-2024.git
cd devtoberfest-2024
npm install
cds watch --port 4004
```

Once running the devtoberfest app will run on [http://localhost:4004](http://localhost:4004), whilst the beershop app will be running on [http://localhost:4005](http://localhost:4005)
