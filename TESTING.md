# Testing and verification

1) Build and start (detached):

   docker-compose up --build -d

2) Check containers are running:

   docker-compose ps

3) Follow logs (if needed):

   docker-compose logs -f web
   docker-compose logs -f db

4) Verify web app responds:

   curl -I http://localhost:8080

5) Verify DB connectivity from the web container (quick check):

   docker-compose exec web bash -c "php -r 'require "admin/db_connect.php"; echo (isset($conn) ? "DB OK" : "DB FAIL");'"

6) Verify uploads directory permissions (from host):

   ls -la admin/assets/uploads

7) Access phpMyAdmin (optional):

   http://localhost:8081   (use `root` / `rootpassword`)

8) To reinitialize DB (destroys data):

   docker-compose down -v
   docker-compose up --build

9) Stop and remove containers:

   docker-compose down

If you hit issues, check container logs and confirm the `bidding_db.sql` file exists at `./database/bidding_db.sql` and is readable.
