#ifndef FIRE_VEC3_HPP
#define FIRE_VEC3_HPP

/// A mathematical 3-dimensional vector containing an X, Y and Z component.
/// \tparam T A floating-point or integer data type is expected. Anything else will likely create compiler errors.
template <typename T>
struct Vec3 final
{
    //
    // Constructors and destructor.
    //

    /// \brief Defaults the Vec3 to (0,0,0).
    constexpr Vec3<T>() = default;

    /// \brief Sets each component to the value specified, e.g. (1,1,1).
    /// \param value The value each component should be set to.
    constexpr Vec3<T> (const T value) : x (value), y (value), z (value) { }

    /// \brief Sets the initial value of each component.
    constexpr Vec3<T> (const T x_, const T y_, const T z_) : x (x_), y (y_), z (z_) { }

    constexpr Vec3<T> (const Vec3<T>& copy)             = default;
    constexpr Vec3<T> (Vec3<T>&& move)                  = default;
    constexpr Vec3<T>& operator= (const Vec3<T>& copy)  = default;
    constexpr Vec3<T>& operator= (Vec3<T>&& move)       = default;
    ~Vec3<T>()                                          = default;


    //
    // Static methods.
    //

    static constexpr Vec3<T> zero()     { return { zeroValue }; }
    static constexpr Vec3<T> right()    { return { oneValue, zeroValue, zeroValue }; }
    static constexpr Vec3<T> up()       { return { zeroValue, oneValue, zeroValue }; }
    static constexpr Vec3<T> forward()  { return { zeroValue, zeroValue, oneValue }; }


    //
    // Static members.
    //

    static constexpr T zeroValue        { static_cast<T>(0) };              ///< Represents 0 for the given data type.
    static constexpr T oneValue         { static_cast<T>(1) };              ///< Represents 1 for the given data type.


    //
    // Members.
    //

    T x { zeroValue }; ///< The X component representing left/right.
    T y { zeroValue }; ///< The Y component representing up/down.
    T z { zeroValue }; ///< The Z component representing forward/backward.
};

#endif // FIRE_VEC3_HPP
