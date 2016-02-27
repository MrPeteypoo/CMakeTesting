#include <FireEngine/Math/Vec3Test.hpp>
#include <gtest/gtest.h>

TEST (Vec3FloatTestConstructor, IsConstexprDefaultConstructedToZero)
{
    constexpr auto vec3 = Vec3Float {};
    EXPECT_FLOAT_EQ (vec3.x, 0.f);
    EXPECT_FLOAT_EQ (vec3.y, 0.f);
    EXPECT_FLOAT_EQ (vec3.z, 0.f);
}

TEST (Vec3TestFloat, IsConstexprConstructibleWithSingleValue)
{
    constexpr auto vec3 = Vec3Float { 1.f };
    EXPECT_FLOAT_EQ (vec3.x, 1.f);
    EXPECT_FLOAT_EQ (vec3.y, 1.f);
    EXPECT_FLOAT_EQ (vec3.z, 1.f);
}

TEST (Vec3TestFloat, IsConstexprConstructibleWithAValueForEachComponent)
{
    constexpr auto vec3 = Vec3Float { 1.f, 2.f, 3.f };
    EXPECT_FLOAT_EQ (vec3.x, 1.f);
    EXPECT_FLOAT_EQ (vec3.y, 2.f);
    EXPECT_FLOAT_EQ (vec3.z, 3.f);
}

int main (int argc, char **argv)
{
    ::testing::InitGoogleTest (&argc, argv);
    return RUN_ALL_TESTS();
}
