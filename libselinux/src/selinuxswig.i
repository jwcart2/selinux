/* Authors: Dan Walsh
 *          James Athey
 */

%module selinux
%{
	#include "selinux/selinux.h"
%}
%apply int *OUTPUT { int *enforce };
%apply int *OUTPUT { size_t * };

%typedef unsigned mode_t;

%typemap(in, numinputs=0) (char ***names, int *len) (char **temp1, int temp2) {
	$1 = &temp1;
	$2 = &temp2;
}

%typemap(freearg) (char ***names, int *len) {
	int i;
	if (*$1) {
		for (i = 0; i < *$2; i++) {
			free((*$1)[i]);
		}
		free(*$1);
	}
}

%typemap(in, numinputs=0) (security_context_t **) (security_context_t *temp) {
	$1 = &temp;
}

%typemap(freearg) (security_context_t **) {
	if (*$1) freeconary(*$1);
}

/* Ignore functions that don't make sense when wrapped */
%ignore freecon;
%ignore freeconary;

/* Ignore functions that take a function pointer as an argument */
%ignore set_matchpathcon_printf;
%ignore set_matchpathcon_invalidcon;
%ignore set_matchpathcon_canoncon;

%include "../include/selinux/selinux.h"
%include "../include/selinux/get_default_type.h"
%include "../include/selinux/get_context_list.h"
