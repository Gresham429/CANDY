if(EXISTS "/home/tony/projects/CANDY/build/thirdparty/faiss/tests/faiss_test[1]_tests.cmake")
  include("/home/tony/projects/CANDY/build/thirdparty/faiss/tests/faiss_test[1]_tests.cmake")
else()
  add_test(faiss_test_NOT_BUILT faiss_test_NOT_BUILT)
endif()
