/*
Generic implementation of the admob extension.
This file should perform any platform-indepedentent functionality
(e.g. error checking) before calling platform-dependent implementations.
*/

/*
 * NOTE: This file was originally written by the extension builder, but will not
 * be overwritten (unless --force is specified) and is intended to be modified.
 */


#include "admob_internal.h"
s3eResult admobInit()
{
    //Add any generic initialisation code here
    return admobInit_platform();
}

void admobTerminate()
{
    //Add any generic termination code here
    admobTerminate_platform();
}

s3eResult admob_init(const char* pub_id, int ad_type, int orientation, int x, int y)
{
	return admob_init_platform(pub_id, ad_type, orientation, x, y);
}

s3eResult admob_resize(int ad_type)
{
	return admob_resize_platform(ad_type);
}

s3eResult admob_show()
{
	return admob_show_platform();
}

s3eResult admob_refresh()
{
	return admob_refresh_platform();
}

s3eResult admob_hide()
{
	return admob_hide_platform();
}

s3eResult admob_move(int orientation, int x, int y)
{
	return admob_move_platform(orientation, x, y);
}
