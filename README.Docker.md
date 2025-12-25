# Docker setup for Bidding app

## What was added
- `Dockerfile` — PHP 8.1 + Apache with `mysqli` enabled and a small entrypoint to set upload dir permissions.
- `docker-entrypoint.sh` — ensures `/var/www/html/admin/assets/uploads` exists and is owned by `www-data`.
- `php.ini` — increased upload/post limits and memory limit.
- `docker-compose.yml` — `web` (build), `db` (MariaDB 10.4), and `phpmyadmin` services. The DB dump `database/bidding_db.sql` is mounted into the DB init folder.
- `admin/db_connect.php` — now reads `DB_HOST`, `DB_USER`, `DB_PASS`, `DB_NAME` from environment variables (with fallbacks to previous defaults).

## Default mapped ports
- Web: http://localhost:8080 (maps to container port 80)
- phpMyAdmin (optional): http://localhost:8081 (maps to container port 80)
- MySQL/MariaDB: 3306 mapped to host 3306

## Quick start
1. From project root where `docker-compose.yml` is located, build and start services:

   docker-compose up --build -d

2. Check logs:

   docker-compose logs -f web
   docker-compose logs -f db

3. Visit the app at http://localhost:8080 and phpMyAdmin at http://localhost:8081 (user `root` / password `rootpassword`).

## Notes & troubleshooting
- If you prefer other host ports, edit `docker-compose.yml`.
- If the DB doesn't initialize (e.g., on repeated runs), remove the `db_data` volume to force re-initialization (this will destroy DB data):

  docker-compose down -v
  docker-compose up --build

- Uploaded files are stored at `admin/assets/uploads` on the host; ensure that directory exists and is writable by your user or Docker will set ownership to `www-data` inside the container.

- To change DB credentials, update `docker-compose.yml` and set matching `DB_*` env vars under the `web` service.

## Manual DB import
If you prefer to import the SQL dump manually instead of using the init script, you can run:

  docker-compose exec db bash
  mysql -u root -p bidding_db < /docker-entrypoint-initdb.d/01-init.sql

Password for `root` is the value of `MYSQL_ROOT_PASSWORD` in `docker-compose.yml` (`rootpassword` by default).
