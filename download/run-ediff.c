//start here.
#include <stdio.h>
#include <stdlib.h>

/*
 * compile and link this by VC.
 * call-ediff is used to call ediff from Perforce.
 *  call-ediff c:\a\b\a.txt c:\a\b\b.txt
 *  or
 *  call-ediff c:/a/b/a.txt :/a/b/b.txt
 */

void hackPathSeparator(char *windozePath) {
  char *c;

  for (c = windozePath; *c; c++) {
	if ('\\' == *c)
      *c = '/';
  }
}

int main(int argc, char *argv[], char *envp[]) {
  char *param1 = argv[1];
  char *param2 = argv[2];
  char *command;
  /* We get \ part separators from Perforce; hack these to / */

  hackPathSeparator(param1);
  hackPathSeparator(param2);


  /* /\* hack the arg list (ugh) *\/ */
  command= (char*) malloc(4096);

  sprintf(command, "emacsclientw -eval \"(progn (raise-frame) (ediff \\\"%s\\\" \\\"%s\\\"))\"", param1, param2);
  system( command);
  return 0;
}
//ends here.
