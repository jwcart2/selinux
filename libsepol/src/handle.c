#include <stdlib.h>
#include <assert.h>
#include "handle.h"
#include "debug.h"

sepol_handle_t *sepol_handle_create(void)
{

	sepol_handle_t *sh = malloc(sizeof(sepol_handle_t));
	if (sh == NULL)
		return NULL;

	/* Set callback */
	sh->msg_callback = sepol_msg_default_handler;
	sh->msg_callback_arg = NULL;

	/* by default do not disable dontaudits */
	sh->disable_dontaudit = 0;

	return sh;
}

void sepol_set_disable_dontaudit(sepol_handle_t * sh, int disable_dontaudit)
{
	assert(sh !=NULL);
	sh->disable_dontaudit = disable_dontaudit;
}

void sepol_handle_destroy(sepol_handle_t * sh)
{
	free(sh);
}
