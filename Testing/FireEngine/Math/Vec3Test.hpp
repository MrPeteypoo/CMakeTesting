//#include <FireEngine/Math/Vec3.hpp>
#include <gtest/gtest.h>

namespace fire { template<typename T> struct Vec3 {T x, y, z;};}

class Vec3Test : public ::testing::Test
{
    protected:
        fire::Vec3<float> vec3;
};
