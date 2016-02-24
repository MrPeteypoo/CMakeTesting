#include <FireEngine/Math/Vec3Test.hpp>

TEST_F(Vec3Test, IsDefaultConstructible)
{
    SUCCEED();
}

int main(int argc, char **argv)
{
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
