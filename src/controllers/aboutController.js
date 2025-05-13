const About = require("../models/aboutModel");

const getAboutPage = async (req, res) => {
  try {
    const teamMembers = await About.getTeamMembers();

    res.status(200).json({ message: "Página Sobre carregada com sucesso.", data: teamMembers });
  } catch (error) {
    console.error("Erro ao carregar página Sobre:", error);
    res.status(500).json({ error: "Erro ao carregar página Sobre.", details: error.message });
  }
};

const createAbout = async (req, res) => {
  try {
    const about = await About.createAboutPage(req.body);
    res.status(201).json({ message: "Página criada com sucesso.", data: about });
  } catch (err) {
    console.error("Erro ao criar página:", err);
    res.status(500).json({ error: "Erro ao criar página.", details: err.message });
  }
};

const updateAbout = async (req, res) => {
  const { id } = req.params;
  try {
    const updated = await About.updateAboutPage(id, req.body);
    res.status(200).json({ message: "Página atualizada com sucesso.", data: updated });
  } catch (err) {
    console.error("Erro ao atualizar página:", err);
    res.status(500).json({ error: "Erro ao atualizar página.", details: err.message });
  }
};

const addMember = async (req, res) => {
  try {
    const member = await About.addTeamMember(req.body);
    res.status(201).json({ message: "Membro adicionado com sucesso.", data: member });
  } catch (err) {
    console.error("Erro ao adicionar membro:", err);
    res.status(500).json({ error: "Erro ao adicionar membro.", details: err.message });
  }
};

const updateMember = async (req, res) => {
  const { id } = req.params;
  try {
    const updated = await About.updateTeamMember(id, req.body);
    res.status(200).json({ message: "Membro atualizado com sucesso.", data: updated });
  } catch (err) {
    console.error("Erro ao atualizar membro:", err);
    res.status(500).json({ error: "Erro ao atualizar membro.", details: err.message });
  }
};

const deleteMember = async (req, res) => {
  const { id } = req.params;
  try {
    const deleted = await About.deleteTeamMember(id);
    res.status(200).json({ message: "Membro removido com sucesso.", data: deleted });
  } catch (err) {
    console.error("Erro ao remover membro:", err);
    res.status(500).json({ error: "Erro ao remover membro.", details: err.message });
  }
};

const getMemberById = async (req, res) => {
  const { id } = req.params;
  try {
    const member = await About.getTeamMemberById(id);

    if (!member) {
      return res.status(404).json({ error: "Membro não encontrado." });
    }

    res.status(200).json({ message: "Membro recuperado com sucesso.", data: member });
  } catch (err) {
    console.error("Erro ao buscar membro:", err);
    res.status(500).json({ error: "Erro ao buscar membro.", details: err.message });
  }
};

const getAllMembers = async (req, res) => {
  const { name } = req.query;

  try {
    let members = await About.getTeamMembers();

    if (name) {
      const filterName = name.toLowerCase();
      members = members.filter((member) =>
        member.name.toLowerCase().includes(filterName)
      );
    }

    res.status(200).json({
      message: "Membros listados com sucesso.",
      data: members,
    });
  } catch (err) {
    console.error("Erro ao buscar membros:", err);
    res.status(500).json({
      error: "Erro ao buscar membros.",
      details: err.message,
    });
  }
};

module.exports = {
  getAboutPage,
  createAbout,
  updateAbout,
  addMember,
  updateMember,
  deleteMember,
  getMemberById,
  getAllMembers,
};