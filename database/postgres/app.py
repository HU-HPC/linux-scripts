import docker
import random
import string
import sys

client = docker.from_env()


def create_postgres_container(container_name,db_name, db_user, db_password, db_port, container_data):
    postgres_container = client.containers.run(
        image='postgres:latest',
        name=f'{container_name}',
        environment={
            'POSTGRES_DB': f'{db_name}',
            'POSTGRES_USER': f'{db_user}',
            'POSTGRES_PASSWORD': f'{db_password}'
        },
        ports={
            '5432/tcp': f'{db_port}'
        },
        detach=True,
        volumes={
            f'{container_data}': {
                'bind': '/var/lib/postgresql/data',
                'mode': 'rw'
            }
        },
        restart_policy={
            'Name': 'always'
        }
    )
    return postgres_container


def generate_container_info():
    container_name = 'PG_' + ''.join(random.choices(string.ascii_lowercase + string.digits, k=10))
    db_name = ''.join(random.choices(string.ascii_lowercase + string.digits, k=10))
    db_user = ''.join(random.choices(string.ascii_lowercase + string.digits, k=10))
    db_password = ''.join(random.choices(string.ascii_lowercase + string.digits, k=10))
    db_port = random.randint(10000, 60000)
    container_data = 'PG_'+''.join(random.choices(string.ascii_lowercase + string.digits, k=10))
    return container_name, db_name, db_user, db_password, db_port , container_data

def stop_all_containers():
    containers = client.containers.list()
    for container in containers:
        if container.name.startswith('PG'):
            container.stop()
            container.remove()
            print("Container ", container.name, " stopped and removed")

def remove_volumes():
    volumes = client.volumes.list()
    for volume in volumes:
        if volume.name.startswith('PG'):
            volume.remove()
            print("Volume ", volume.name, " removed")

def main():
    container_name, db_name, db_user, db_password, db_port, container_data = generate_container_info()
    postgres_container = create_postgres_container(container_name, db_name, db_user, db_password, db_port,container_data)
    print("DB Name: ", db_name, "  ", "DB User: ", db_user, "  ", "DB Password: ", db_password, "  ", "DB Port: ", db_port)


if __name__ == '__main__':
    students = 0
    if len(sys.argv) > 1:
        if sys.argv[1] == 'stop':
            stop_all_containers()
            sys.exit()
        elif sys.argv[1] == 'create':
            if sys.argv[2].isdigit():
                students = int(sys.argv[2])
            else:
                print("Please enter a number")
                sys.exit()
            for i in range(students):
                main()
        elif sys.argv[1] == 'volremove':
            remove_volumes()
        else:
            print("Please enter create or stop")
            sys.exit()
    else:
        print("Please enter create or stop")
        sys.exit()
