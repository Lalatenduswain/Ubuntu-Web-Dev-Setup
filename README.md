# Installation Script

This script automates the installation of a development environment with the required dependencies, web servers, database servers, phpMyAdmin, Composer, and Git. It is designed for Debian based Operating Systems.

## Prerequisites

Before running the script, make sure you have the following prerequisites installed:

- Ubuntu (or Ubuntu-based) system
- `sudo` access
- `curl`
- `git`

## Instructions

1. Clone the repository:

```bash
git clone git@github.com:Lalatenduswain/apache-n-sql.git
```

2. Change into the repository directory:

```bash
cd apache-n-sql
```

3. Make the script executable:

```bash
chmod +x lalatendu.sh
```

4. Run the installation script:

```bash
./lalatendu.sh
```

5. Follow the prompts to select the web server (Apache or Nginx), the database server (MySQL, MariaDB, or PostgreSQL), and Composer installation.

6. Wait for the installation to complete.

7. Access your development environment at the appropriate URL based on the web server you selected.

## Components

The script installs the following components:

- Apache
- Nginx
- MySQL
- MariaDB
- PostgreSQL
- phpMyAdmin
- Composer
- Git

## Disclaimer

This script is provided as-is without any warranty. Use it at your own risk.

## License

This project is licensed under the [MIT License](LICENSE).
```

Please ensure that you have the correct SSH clone URL and replace it in the instructions section.
