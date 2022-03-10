function Form() {
  return (
    <div className="rounded-lg bg-slate-100 p-3">
      <form className="flex flex-col">
        <label className="mb-1 font-bold" htmlFor="username">
          Username
        </label>
        <input
          className="mb-3 rounded border-2 p-1 px-3"
          type="text"
          id="username"
        />

        <label className="mb-1 font-bold" htmlFor="age">
          Age (Year)
        </label>
        <input
          className="mb-3 rounded border-2 p-1 px-3"
          type="number"
          id="age"
          min="0"
          step="1"
        />

        <button
          className="w-fit rounded bg-purple-900 py-2 px-4 text-white"
          type="submit"
        >
          Add User
        </button>
      </form>
    </div>
  );
}

export default Form;
