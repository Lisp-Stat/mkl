
<!-- PROJECT SHIELDS -->

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MS-PL License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/lisp-stat/mkl">
    <img src="https://lisp-stat.dev/images/stats-image.svg" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">MKL</h3>

  <p align="center">
  Intel Math Kernel Library bindings for Common Lisp
	<br />
    <a href="https://lisp-stat.dev/docs/manuals/mkl/"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/lisp-stat/mkl/issues">Report Bug</a>
    ·
    <a href="https://github.com/lisp-stat/mkl/issues">Request Feature</a>
    ·
    <a href="https://lisp-stat.github.io/mkl/">Reference Manual</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About the Project</a>
      <ul>
        <li><a href="#objectives">Objectives</a></li>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#systems">Systems</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About the Project

MKL provides Common Lisp bindings for Intel's Math Kernel Library, offering access to performance-optimized mathematical functions.


### Objectives

- **Direct MKL integration**: Provide bindings to Intel MKL functions with minimal overhead and direct access to optimized mathematical operations.

- **Performance optimization**: Enable Common Lisp applications to benefit from Intel MKL's hardware-specific optimizations and vectorized operations.

- **Vector mathematics**: Implement efficient vector mathematical operations through the VML (Vector Math Library) component.

- **Library compatibility**: Maintain compatibility with existing Common Lisp mathematical libraries and development workflows.

### Built With

* [CFFI](https://github.com/cffi/cffi)
* [Alexandria](https://github.com/keithj/alexandria)
* [LLA](https://github.com/lisp-stat/lla)


## Getting Started

MKL requires Intel Math Kernel Library to be installed on your system before loading. The library provides bindings to MKL functions and does not include the MKL libraries themselves.

### Prerequisites

MKL requires Intel Math Kernel Library shared libraries to be available on your system. You can install MKL through:

- [Intel oneAPI Base Toolkit](https://www.intel.com/content/www/us/en/developer/tools/oneapi/base-toolkit.html) (includes MKL)
- [Standalone Intel MKL installation](https://www.intel.com/content/www/us/en/developer/tools/oneapi/onemkl.html)
- Package managers on Linux distributions that provide MKL packages

Ensure that the MKL libraries are accessible through your system's library search path or configure the library locations as described in the installation section.

### Installation

#### Using Quicklisp

The recommended installation method is through [Quicklisp](https://www.quicklisp.org/beta/). Load specific MKL subsystems as needed:

```lisp
(ql:quickload :mkl/vml)    ; Vector Math Library
(ql:quickload :mkl/fft)    ; Fast Fourier Transform (if available)
(ql:quickload :mkl/dnn)    ; Deep Neural Networks (if available)
```

Note: Quicklisp distributions are not updated frequently. If MKL subsystems are not available through Quicklisp, use the manual installation method described below.

#### Manual Installation

To make the system accessible to [ASDF](https://common-lisp.net/project/asdf/) (a build facility, similar to `make` in the C world), clone the repository in a directory ASDF knows about. By default the `common-lisp` directory in your home directory is known. Create this if it doesn't already exist and then:

1. Clone the repository
```sh
cd ~/common-lisp && \
git clone https://github.com/lisp-stat/mkl.git
```
2. Reset the ASDF source-registry to find the new system (from the REPL)
   ```lisp
   (asdf:clear-source-registry)
   ```
3. Load the desired MKL subsystems
   ```lisp
   (asdf:load-system :mkl/vml)    ; Vector Math Library
   (asdf:load-system :mkl/fft)    ; Fast Fourier Transform (if available)
   (asdf:load-system :mkl/dnn)    ; Deep Neural Networks (if available)
   ```

If you have installed the slime ASDF extensions, you can invoke this with a comma (',') from the slime REPL.

#### Getting dependencies

To get the third party systems that MKL depends on, you can use a dependency manager, such as [Quicklisp](https://www.quicklisp.org/beta/) or [CLPM](https://www.clpm.dev/) Once installed, get the dependencies with either of:

```lisp
(clpm-client:sync :sources "clpi") ;sources may vary
```

```lisp
(ql:quickload :mkl/vml)  ; This will also install dependencies
```

You need do this only once. After obtaining the dependencies, you can load the subsystems with `ASDF` as described above without first syncing sources.


## Systems

### VML (Vector Math Library)

The VML system provides bindings to Intel MKL's Vector Math Library, which implements optimized mathematical functions for arrays and vectors. VML operations process multiple data elements in parallel, providing significant performance improvements over scalar implementations.

The VML system includes:

- Vectorized mathematical functions (trigonometric, exponential, logarithmic, power functions)
- Element-wise array operations
- Configurable accuracy modes and error handling
- Support for single and double precision floating-point data

Load the VML system with:

```lisp
(asdf:load-system :mkl/vml)
```

or

```lisp
(ql:quickload :mkl/vml)
```


<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**. Please see CONTRIBUTING for details on the code of conduct, and the process for submitting pull requests.

<!-- LICENSE -->
## License

Distributed under the MS-PL License. See [`LICENSE`](LICENSE) for more information.

<!-- CONTACT -->
## Contact

Project Link: [https://github.com/lisp-stat/mkl](https://github.com/lisp-stat/mkl)



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/lisp-stat/mkl.svg?style=for-the-badge
[contributors-url]: https://github.com/lisp-stat/mkl/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/lisp-stat/mkl.svg?style=for-the-badge
[forks-url]: https://github.com/lisp-stat/mkl/network/members
[stars-shield]: https://img.shields.io/github/stars/lisp-stat/mkl.svg?style=for-the-badge
[stars-url]: https://github.com/lisp-stat/mkl/stargazers
[issues-shield]: https://img.shields.io/github/issues/lisp-stat/mkl.svg?style=for-the-badge
[issues-url]: https://github.com/lisp-stat/mkl/issues
[license-shield]: https://img.shields.io/github/license/lisp-stat/mkl.svg?style=for-the-badge
[license-url]: https://github.com/lisp-stat/mkl/blob/master/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/company/symbolics/


