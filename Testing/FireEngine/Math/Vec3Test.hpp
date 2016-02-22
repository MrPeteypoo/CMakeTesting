//#include <FireEngine/Math/Vec3.hpp>
#include <gtest/gtest.h>

namespace fire { template<typename T> struct Vec3 {T x, y, z;};}

template <typename T>
class Vec3Test : public ::testing::Test
{
    protected:
        fire::Vec3<T> vec3;
}
