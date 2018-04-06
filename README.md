# Ordnunger

Basically, I wanted to check if [Distillery](https://github.com/bitwalker/distillery) is any better than exrm was.

It is. Nice!

<!-- ![screenshot](https://github.com/piotrklibert/ordnunger/blob/master/screen.png) -->

## Docker image

You can use a pre-built image: `piotrklibert/ordnunger`

You can also build the image yourself, with:

    docker build -t ordnunger .


### Configuration

The only env variable needed by Ordnunger is `MEMBERS`. It should be a list of
strings, in JSON syntax, for example:

    MEMBERS=["Mary Sue", "Gary Stu"]

It's recommended to put this definition into a file which can be used with
`--env-file` Docker option.


### Running

To run the service with interactive console attached, use:

    docker run -ti --env-file docker.env -p 4000:4000 piotrklibert/ordnunger console

To start a detached container:

    docker run -d --env-file docker.env -p 4000:4000 piotrklibert/ordnunger foreground

Go to `http://localhost:4000/`, the service should be running.

See also [lib](/lib/)
