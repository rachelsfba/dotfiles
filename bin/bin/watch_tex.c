/* File: watch_tex.c
 *
 * Description: Poll for changes in a given files. If changed, run pdflatex on
 * the main TeX file.
 *
 * Last modified: 22 October 2017
 */

#include <stdio.h>
#include <stdlib.h>
#include <sys/inotify.h>
#include <unistd.h>
#include <err.h>

typedef signed int fd_t;

void poll_for_changes(char* dir) {
    int result;
    fd_t ifd;
    
    ifd = inotify_init();

    if (ifd == -1) {
        err(2, "Inotify failed to initialize");
    }

    result = inotify_add_watch(ifd, dir, IN_MODIFY | IN_CREATE | IN_DELETE);
}

int main(int argc, char* argv[])
{
    char* watchdir;

    if (argc == 1) {
        watchdir = "./";    
    } else {
        watchdir = argv[1];
    }

    printf("You want me to watch '%s', right?\n", watchdir);
    
    return 0;
}
