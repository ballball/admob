/*
Internal header for the admob extension.

This file should be used for any common function definitions etc that need to
be shared between the platform-dependent and platform-indepdendent parts of
this extension.
*/

/*
 * NOTE: This file was originally written by the extension builder, but will not
 * be overwritten (unless --force is specified) and is intended to be modified.
 */


#ifndef ADMOB_H_INTERNAL
#define ADMOB_H_INTERNAL

#include "s3eTypes.h"
#include "admob.h"
#include "admob_autodefs.h"


/**
 * Initialise the extension.  This is called once then the extension is first
 * accessed by s3eregister.  If this function returns S3E_RESULT_ERROR the
 * extension will be reported as not-existing on the device.
 */
s3eResult admobInit();

/**
 * Platform-specific initialisation, implemented on each platform
 */
s3eResult admobInit_platform();

/**
 * Terminate the extension.  This is called once on shutdown, but only if the
 * extension was loader and Init() was successful.
 */
void admobTerminate();

/**
 * Platform-specific termination, implemented on each platform
 */
void admobTerminate_platform();
s3eResult admob_init_platform(const char* pub_id, int ad_type, int orientation, int x, int y);

s3eResult admob_resize_platform(int ad_type);

s3eResult admob_show_platform();

s3eResult admob_refresh_platform();

s3eResult admob_hide_platform();

s3eResult admob_move_platform(int orientation, int x, int y);


#endif /* ADMOB_H_INTERNAL */