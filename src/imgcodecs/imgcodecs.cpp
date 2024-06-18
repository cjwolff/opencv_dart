/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "imgcodecs.h"
#include <vector>

CvStatus *Image_IMRead(const char *filename, int flags, Mat *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Mat(cv::imread(filename, flags))};
  END_WRAP
}
CvStatus *Image_IMWrite(const char *filename, Mat img, bool *rval)
{
  BEGIN_WRAP
  *rval = cv::imwrite(filename, *img.ptr);
  END_WRAP
}
CvStatus *Image_IMWrite_WithParams(const char *filename, Mat img, VecInt params, bool *rval)
{
  BEGIN_WRAP
  *rval = cv::imwrite(filename, *img.ptr, *params.ptr);
  END_WRAP
}
CvStatus *Image_IMEncode(const char *fileExt, Mat img, bool *success, VecUChar *rval)
{
  BEGIN_WRAP
  std::vector<uchar> buf;
  *success = cv::imencode(fileExt, *img.ptr, buf);
  *rval = {new std::vector<uchar>(buf)};
  END_WRAP
}
CvStatus *Image_IMEncode_WithParams(const char *fileExt, Mat img, VecInt params, bool *success,
                                    VecUChar *rval)
{
  BEGIN_WRAP
  std::vector<uchar> buf;
  *success = cv::imencode(fileExt, *img.ptr, buf, *params.ptr);
  *rval = {new std::vector<uchar>(buf)};
  END_WRAP
}
CvStatus *Image_IMDecode(VecUChar buf, int flags, Mat *rval)
{
  BEGIN_WRAP
  auto m = cv::imdecode(*buf.ptr, flags);
  *rval = {new cv::Mat(m)};
  END_WRAP
}
