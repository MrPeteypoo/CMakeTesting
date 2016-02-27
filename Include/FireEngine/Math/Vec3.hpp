#ifndef FIRE_VEC3_HPP
#define FIRE_VEC3_HPP

#include <FireEngine/Utility/TypeTraits.hpp>

namespace fire
{
    /// A mathematical 3-dimensional vector containing an X, Y and Z component. This can be used extensively as a constexpr
    /// entity for compile-time computation.
    /// \tparam T A floating-point or integer data type is expected. Anything else will likely create compiler errors.
    template <typename T>
    struct Vec3 final
    {
        // Require T to be an arithmetic type and not a bool.
        //static_assert (is_arithmetic_excluding_v<T, bool, char>,
        //    "Vec3 can only be instantiated with arithmetic types, excluding bool.");

        //
        // Constructors and destructor.
        //

        /// \brief Defaults the Vec3 to (0,0,0).
        constexpr Vec3<T>() noexcept = default;

        /// \brief Sets each component to the value specified, e.g. (1,1,1).
        /// \param value The value each component should be set to.
        constexpr Vec3<T> (const T value) noexcept
            : x (value), y (value), z (value) { }

        /// \brief Sets the initial value of each component.
        constexpr Vec3<T> (const T x_, const T y_, const T z_) noexcept
            : x (x_), y (y_), z (z_) { }

        constexpr Vec3<T> (const Vec3<T>& copy) noexcept            = default;
        constexpr Vec3<T> (Vec3<T>&& move) noexcept                 = default;
        constexpr Vec3<T>& operator= (const Vec3<T>& copy) noexcept = default;
        constexpr Vec3<T>& operator= (Vec3<T>&& move) noexcept      = default;
        ~Vec3<T>() noexcept                                         = default;

        //
        // Static methods.
        //

        // All type statics.
        static constexpr Vec3<T> zero() noexcept    { return { zeroValue }; }
        static constexpr Vec3<T> right() noexcept   { return { oneValue, zeroValue, zeroValue }; }
        static constexpr Vec3<T> up() noexcept      { return { zeroValue, oneValue, zeroValue }; }
        static constexpr Vec3<T> back() noexcept    { return { zeroValue, zeroValue, oneValue }; }

        // Signed-only statics.
        static constexpr Vec3<enable_if_signed_t<T>> left() noexcept { return { -oneValue, zeroValue, zeroValue }; }
        static constexpr Vec3<enable_if_signed_t<T>> down() noexcept { return { zeroValue, -oneValue, zeroValue }; }
        static constexpr Vec3<enable_if_signed_t<T>> forward() noexcept { return { zeroValue, zeroValue, -oneValue }; }

        //
        // Static members.
        //

        static constexpr T zeroValue    { T (0) };  ///< Represents 0 for the given data type.
        static constexpr T oneValue     { T (1) };  ///< Represents 1 for the given data type.

        //
        // Members.
        //

        T x { zeroValue };  ///< The X component representing right/left.
        T y { zeroValue };  ///< The Y component representing up/down.
        T z { zeroValue };  ///< The Z component representing forward/backward.
    };
}
#endif // FIRE_VEC3_HPP
