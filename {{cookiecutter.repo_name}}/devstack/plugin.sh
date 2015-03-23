# check for service enabled
if is_service_enabled {{cookiecutter.service}}; then
    if [[ "$1" == "source" ]]; then
        # Initial source of lib script
        source $(dirname "$0")/lib/{{cookiecutter.service}}
    fi

    if [[ "$1" == "stack" && "$2" == "pre-install" ]]; then
        # Set up system services
        echo_summary "Configuring system services {{cookiecutter.service}}"
        pre_install_{{cookiecutter.service}}

    elif [[ "$1" == "stack" && "$2" == "install" ]]; then
        # Perform installation of service source
        echo_summary "Installing {{cookiecutter.service}}"
        install_{{cookiecutter.service}}

    elif [[ "$1" == "stack" && "$2" == "post-config" ]]; then
        # Configure after the other layer 1 and 2 services have been configured
        echo_summary "Configuring {{cookiecutter.service}}"
        configure_{{cookiecutter.service}}

    elif [[ "$1" == "stack" && "$2" == "extra" ]]; then
        # Initialize and start the {{cookiecutter.service}} service
        echo_summary "Initializing {{cookiecutter.service}}"
        init_{{cookiecutter.service}}
    fi

    if [[ "$1" == "unstack" ]]; then
        # Shut down {{cookiecutter.service}} services
        # no-op
        shutdown_{{cookiecutter.service}}
    fi

    if [[ "$1" == "clean" ]]; then
        # Remove state and transient data
        # Remember clean.sh first calls unstack.sh
        # no-op
        cleanup_{{cookiecutter.service}}
    fi
fi
