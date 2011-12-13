/*
 * WARNING: this is an autogenerated file and will be overwritten by
 * the extension interface script.
 */

#include "s3eExt.h"
#include "IwDebug.h"

#include "admob.h"

/**
 * Definitions for functions types passed to/from s3eExt interface
 */
typedef  s3eResult(*admob_init_t)(const char* pub_id, int ad_type, int orientation, int x, int y);
typedef  s3eResult(*admob_resize_t)(int ad_type);
typedef  s3eResult(*admob_show_t)();
typedef  s3eResult(*admob_refresh_t)();
typedef  s3eResult(*admob_hide_t)();
typedef  s3eResult(*admob_move_t)(int orientation, int x, int y);

/**
 * struct that gets filled in by admobRegister
 */
typedef struct admobFuncs
{
    admob_init_t m_admob_init;
    admob_resize_t m_admob_resize;
    admob_show_t m_admob_show;
    admob_refresh_t m_admob_refresh;
    admob_hide_t m_admob_hide;
    admob_move_t m_admob_move;
} admobFuncs;

static admobFuncs g_Ext;
static bool g_GotExt = false;
static bool g_TriedExt = false;
static bool g_TriedNoMsgExt = false;

static bool _extLoad()
{
    if (!g_GotExt && !g_TriedExt)
    {
        s3eResult res = s3eExtGetHash(0xf12fd48, &g_Ext, sizeof(g_Ext));
        if (res == S3E_RESULT_SUCCESS)
            g_GotExt = true;
        else
            s3eDebugAssertShow(S3E_MESSAGE_CONTINUE_STOP_IGNORE, "error loading extension: admob");
        g_TriedExt = true;
        g_TriedNoMsgExt = true;
    }

    return g_GotExt;
}

static bool _extLoadNoMsg()
{
    if (!g_GotExt && !g_TriedNoMsgExt)
    {
        s3eResult res = s3eExtGetHash(0xf12fd48, &g_Ext, sizeof(g_Ext));
        if (res == S3E_RESULT_SUCCESS)
            g_GotExt = true;
        g_TriedNoMsgExt = true;
        if (g_TriedExt)
            g_TriedExt = true;
    }

    return g_GotExt;
}

s3eBool admobAvailable()
{
    _extLoadNoMsg();
    return g_GotExt ? S3E_TRUE : S3E_FALSE;
}

s3eResult admob_init(const char* pub_id, int ad_type, int orientation, int x, int y)
{
    IwTrace(ADMOB_VERBOSE, ("calling admob[0] func: admob_init"));

    if (!_extLoad())
        return S3E_RESULT_ERROR;

    return g_Ext.m_admob_init(pub_id, ad_type, orientation, x, y);
}

s3eResult admob_resize(int ad_type)
{
    IwTrace(ADMOB_VERBOSE, ("calling admob[1] func: admob_resize"));

    if (!_extLoad())
        return S3E_RESULT_ERROR;

    return g_Ext.m_admob_resize(ad_type);
}

s3eResult admob_show()
{
    IwTrace(ADMOB_VERBOSE, ("calling admob[2] func: admob_show"));

    if (!_extLoad())
        return S3E_RESULT_ERROR;

    return g_Ext.m_admob_show();
}

s3eResult admob_refresh()
{
    IwTrace(ADMOB_VERBOSE, ("calling admob[3] func: admob_refresh"));

    if (!_extLoad())
        return S3E_RESULT_ERROR;

    return g_Ext.m_admob_refresh();
}

s3eResult admob_hide()
{
    IwTrace(ADMOB_VERBOSE, ("calling admob[4] func: admob_hide"));

    if (!_extLoad())
        return S3E_RESULT_ERROR;

    return g_Ext.m_admob_hide();
}

s3eResult admob_move(int orientation, int x, int y)
{
    IwTrace(ADMOB_VERBOSE, ("calling admob[5] func: admob_move"));

    if (!_extLoad())
        return S3E_RESULT_ERROR;

    return g_Ext.m_admob_move(orientation, x, y);
}
