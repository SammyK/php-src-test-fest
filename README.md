# PHP TestFest - Docker Setup

These are the Docker files I used for the screencasts about [writing tests for php-src](https://www.sammyk.me/compiling-php-from-source-writing-tests-for-php-source).

## Download Docker

You'll need to have [Docker](https://www.docker.com/) & [Docker Compose](https://docs.docker.com/compose/) installed first.

## Build the containers

Once Docker is installed and running you'll need to build the docker containers from the root of the project directory.

```bash
$ docker-compose build
```

## Start the containers

Then you can run the containers with the following command.

> **Note:** This command will not run in the background so you'll need to open a new terminal window or tab to run any more commands. You can exit with <kbd>ctl</kbd> + <kbd>c</kbd>.

```bash
$ docker-compose up
Creating network "php-src-test-fest_default" with the default driver
Creating php-src-test-fest_web_1 ... done
Attaching to php-src-test-fest_web_1
```

The shared `docker-mount/` directory is mapped to `/usr/src` in the web container.

## Interactive Shell

You can access the web container's TTY with the following command:

```bash
$ docker exec -it -u tester php-src-test-fest_web_1 bash
```

The user `tester` has sudo privileges and the password is `test123`.

## Stop all the containers

You can stop all the containers by running:

```bash
$ docker-compose stop
```

## Clone PHP

Once you're in the container's interactive shell, you can cd into the shared directory and clone the [php-src repo](https://github.com/php/php-src).

```bash
$ cd /usr/src
$ git clone https://github.com/php/php-src.git
```

Once cloned, you can cd into the new `php-src` directory and compile PHP from source!

```bash
$ cd php-src
$ make distclean && ./vcsclean
$ ./buildconf
$ ./configure --enable-maintainer-zts \
        --enable-debug \
        --enable-cli \
        --with-zlib \
        --enable-mbstring \
        --with-sodium
$ make -j$(($(nproc) + 1))
$ sapi/cli/php --version
```

I hope this helps some of you! Good luck with your tests! :)
