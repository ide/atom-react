describe "React tests", ->
  sampleCorrectFile = require.resolve './fixtures/sample-correct.js'
  sampleInvalidFile = require.resolve './fixtures/sample-invalid.js'

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-javascript")

    waitsForPromise ->
      atom.packages.activatePackage("react")

    afterEach ->
      atom.packages.deactivatePackages()
      atom.packages.unloadPackages()

  describe "should select correct grammar", ->
    it "should select source.js.jsx if file has require('react')", ->
      waitsForPromise ->
        atom.workspace.open(sampleCorrectFile, autoIndent: false).then (editor) ->
          expect(editor.getGrammar().scopeName).toEqual 'source.js.jsx'
          editor.destroy()

    it "should select source.js if file doesnt have require('react')", ->
      waitsForPromise ->
        atom.workspace.open(sampleInvalidFile, autoIndent: false).then (editor) ->
          expect(editor.getGrammar().scopeName).toEqual 'source.js'
          editor.destroy()
