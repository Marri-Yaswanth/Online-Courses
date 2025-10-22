# Online-Courses-Project

Small single-page frontend for an online courses landing site (static HTML/CSS/JS). This repo contains a Dockerfile and docker-compose for serving the static site with Nginx.

## Features
- Responsive design with modern UI
- Interactive video preview modal for each course
- YouTube video integration with autoplay
- Smooth animations and hover effects
- Mobile-friendly navigation

Quick start
1. Serve locally (development, no Docker):

	python3 -m http.server 8000 --directory .

	Then open http://localhost:8000/courses.html

2. Run with Docker (build + run):

	docker build -t online-courses:local .
	docker run --rm -p 8080:80 online-courses:local

	Then open http://localhost:8080/

3. Run with docker-compose:

	docker-compose up --build

Smoke test

There's a tiny smoke test script included: `smoke-test.sh` that checks the HTTP 200 response and a page title. Run it after starting the server:

	./smoke-test.sh http://localhost:8000/courses.html

Notes
- The project is static and intentionally minimal. I fixed a couple of small HTML issues and added a .dockerignore and smoke test.
