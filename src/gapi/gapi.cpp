#include "gapi.h"

CvStatus *GMat_New_Empty(GMat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::GMat()};
  END_WRAP
}

/// not available in 4.9.0 stable
// CvStatus *GMat_New_FromMat(Mat mat, GMat *rval)
// {
//   BEGIN_WRAP
//   *rval = {new cv::GMat(*mat.ptr)};
//   END_WRAP
// }

void GMat_Close(GMatPtr mat)
{
  delete mat->ptr;
  mat->ptr = nullptr;
}
